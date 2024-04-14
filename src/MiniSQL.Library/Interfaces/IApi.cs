using System;
using System.Collections.Generic;
using MiniSQL.Library.Models;

namespace MiniSQL.Library.Interfaces
{
    public interface IApi
    {
        bool IsUsingDatabase { get; }
        void ChangeContext(string newDatabaseName);
        void DropDatabase(string databaseName);
        void ClosePager();
        void FlushPages();
        // return empty list (not null) if nothing to return
        List<SelectResult> Query(string sql);
    }
}
