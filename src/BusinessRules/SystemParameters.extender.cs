using System.Data;
using InfoControl;

namespace Vivina.Erp.BusinessRules
{
    partial class SystemParameterManager
    {
        /// <summary>
        /// This method returns all SystemParameters, as Table
        /// </summary>
        /// <returns></returns>
        public DataTable GetAllSystemParametersTable()
        {
            return GetAllSystemParameters().ToDataTable();
        }
    }
}