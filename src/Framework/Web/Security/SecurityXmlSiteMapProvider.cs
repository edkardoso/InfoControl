﻿using System;
using System.Linq;
using System.Collections.Specialized;
using System.Web;
using InfoControl.Data;
using InfoControl.Properties;
using InfoControl.Web.Security.DataEntities;
using System.Collections.Generic;

namespace InfoControl.Web.Security
{
    public class SecurityXmlSiteMapProvider : XmlSiteMapProvider
    {
        public DataManager _dataManager = new DataManager(false);
        private bool isRegisterFunctions = false;
        private List<Function> functions = null;

        #region Events

        protected event CreatingSiteMapNodeEventHandler CreatingSiteMapNodeEventHandler;

        protected virtual void OnCreatingSiteMapNode(object e, CreatingSiteMapNodeArgs args)
        {
        }

        #endregion

        #region Methods

        public override void Initialize(string name, NameValueCollection attributes)
        {
            base.Initialize(name, attributes);
            CreatingSiteMapNodeEventHandler += OnCreatingSiteMapNode;

            using (var manager = new FunctionManager(null))
                functions = manager.GetAllFunctions().ToList();

            RegisterFunctions(RootNode);
        }

        public override bool IsAccessibleToUser(HttpContext context, SiteMapNode node)
        {
            if (isRegisterFunctions)
                return true;

            if (!base.IsAccessibleToUser(context, node))
                return false;

            string functionName = node[Resources.PermissionRequiredKey];
            if (functionName == null)
                return true;

            string debug = node["debug"];
            if (debug == "true")
                return true;

            var user = context.User as AccessControlPrincipal;
            if (user != null)
            {
                if (node.Roles.Count > 0)
                {
                    foreach (object obj in node.Roles)
                    {
                        if (user.Roles.Contains(obj.ToString()))
                            return true;
                    }
                }

                return user.CanView(functionName.Trim());
            }

            return false;
        }

        /// <summary>
        /// Perform the full SiteMapTree and register functions
        /// </summary>
        /// <param name="node">SiteMapNode that will registered</param>
        /// <returns>Id the function</returns>
        protected virtual void RegisterFunctions(SiteMapNode node)
        {
            node.ReadOnly = false;
            isRegisterFunctions = true;

            //
            // Check if the function is registered
            //
            var function = new Function();
            string permissionRequiredKey = Resources.PermissionRequiredKey;
            if (!String.IsNullOrEmpty(node[permissionRequiredKey]))
            {
                //
                // Get the full path name
                //
                String title = node.Title;
                SiteMapNode parentNode = node.ParentNode;
                while (parentNode != null && !String.IsNullOrEmpty(parentNode.Title))
                {
                    title = parentNode.Title + " > " + title;
                    parentNode = parentNode.ParentNode;
                }
                title = title.Trim().Trim('>').Trim();


                function = functions.Where(f => f.Name == title).FirstOrDefault() ?? new Function();
                function.Name = title;
                if (function.FunctionId == 0)
                {
                    function.CodeName = node[permissionRequiredKey].Trim();
                    using (var manager = new FunctionManager(null))
                        manager.Insert(function);
                }
                else
                {
                    node.ResourceKey = function.FunctionId.ToString();
                    if (!String.IsNullOrEmpty(function.Description))
                        node.Description = function.Description;


                    if (!String.IsNullOrEmpty(node.ParentNode.ResourceKey))
                        if (function.ParentId.ToString() != node.ParentNode.ResourceKey)
                            using (var manager = new FunctionManager(null))
                            {
                                // Recupera do banco para criar o link e deixar o objeto ativo
                                function = manager.GetFunction(title);
                                function.ParentId = Convert.ToInt32(node.ParentNode.ResourceKey);
                                manager.DbContext.SubmitChanges();
                            }
                }

            }

            var args = new CreatingSiteMapNodeArgs(node, node[permissionRequiredKey], function.FunctionId);
            CreatingSiteMapNodeEventHandler(new object(), args);

            isRegisterFunctions = false;


            //
            // Perfoms the tree
            //
            foreach (SiteMapNode childNode in node.ChildNodes) RegisterFunctions(childNode);
        }

        #endregion

        public DataManager DataManager
        {
            get { return _dataManager; }
        }
    }

    public class CreatingSiteMapNodeArgs : EventArgs
    {
        private string _functionCodeName;
        private int _functionId;
        private SiteMapNode _node;

        public CreatingSiteMapNodeArgs(SiteMapNode node, String functionCodeName, Int32 functionId)
        {
            _node = node;
            _functionCodeName = functionCodeName;
            _functionId = functionId;
        }

        public SiteMapNode Node
        {
            get { return _node; }
        }

        public string FunctionCodeName
        {
            get { return _functionCodeName; }
        }

        public int FunctionId
        {
            get { return _functionId; }
        }
    }

    public delegate void CreatingSiteMapNodeEventHandler(object e, CreatingSiteMapNodeArgs args);
}