package com.hobbycam.db;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class HobbyDB {
	
	static DataSource ds;
	
	//static block
	static {
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Connection getConn() throws Exception{
		
		return ds.getConnection();

	}
}
