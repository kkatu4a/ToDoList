#ifndef DATABASE_H
#define DATABASE_H
#include "SQLiteCpp/include/SQLiteCpp/SQLiteCpp.h"

class DataBase{
public:
    SQLite::Database db;
    DataBase(const std::string path): db(path, SQLite::OPEN_READWRITE | SQLite::OPEN_CREATE) {
        try{
            this->db = SQLite::Database(path, SQLite::OPEN_READWRITE | SQLite::OPEN_CREATE);
        } catch (const std::exception& e) {
            throw std::runtime_error("Ошибка подключения к бд");
        }
    }

};

#endif // DATABASE_H
