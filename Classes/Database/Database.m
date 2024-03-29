#import "Database.h"
#import "Statement.h"

@interface Database (Private)
+ (void)createSchemaInfoTable;
+ (void)createDecksTable;
+ (void)createCardsTable;
@end

static sqlite3 *database;

@implementation Database

// Open the database connection.

+ (sqlite3 *)connection {
	if (database != nil) return database;
	
	// The database is stored in the application bundle. 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingFormat:@"/trips.db"];

	// Open the database. The database was prepared outside the application.
	if (sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
		// Even though the open failed, call close to properly clean up resources.
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	}
	return database;
}

+ (Statement *)prepareStatement:(NSString *)sql {
	return [[Statement alloc] initWithDB:[self connection] SQL:sql];
}

+ (int)execute:(NSString *)sql {
	Statement *statement = [self prepareStatement:sql];
	[statement step];
	
	int status = [statement status];
	if (status != SQLITE_OK && status != SQLITE_DONE && status != SQLITE_ROW) {
		NSAssert1(0, @"Failed to execute: '%s'.", sqlite3_errmsg(database));
	}
	[statement finalize];
	
	return status;
}

+ (NSInteger)getSchemaVersion {
	if (![self tableExists:@"schema_info"]) return -1;
	
	Statement *statement = [self prepareStatement:@"SELECT version FROM schema_info;"];
	NSInteger version = -1;
	
	@try {
		[statement nextRow];
		version = [statement intAtColumn:0];
	}
	@finally {
		[statement finalize];
	}
	return version;
}

+ (void)updateSchemaVersion:(int)version {
	NSString *formattedSql = [[NSString alloc] 
			initWithFormat:@"update schema_info set version = %d;", version];
	[self execute:formattedSql];
}

+ (BOOL)tableExists:(NSString *)tableName {
	BOOL found = NO;
	Statement *statement;
	NSString *formattedSql;
	
	@try {
		formattedSql = [[NSString alloc] 
			initWithFormat:@"SELECT name FROM sqlite_master WHERE type='table' AND name='%s';", 
									    tableName];
											
		statement = [self prepareStatement:formattedSql];
		while ([statement nextRow]) {
			found = YES;
		}
	}
	@finally {
		[statement finalize];
		[formattedSql release];
	}
	return found;
}

+ (void)dropAllTables {
	Statement *statement;
	NSMutableArray *tables = [[NSMutableArray alloc] init];
	
	@try {
		NSLog(@"%s dropping tables", _cmd);

		statement = [self prepareStatement:@"SELECT name FROM sqlite_master WHERE type='table';"];
		while ([statement nextRow]) {
			[tables addObject:[statement textAtColumn:0]];
		}
		[statement finalize];

	  for (NSString *tableName in tables) {
		  NSLog(@"%s dropping table %@", _cmd, tableName);
			[self execute:[[NSString alloc] initWithFormat:@"drop table %@;", tableName]];
		}		
	}
	@finally {
		[statement finalize];	
	  [tables release];
	}
}

+ (void)close {
	if (database != nil) {
		sqlite3_close(database);
		database = nil;
	}
}


+ (void)remigrate {
	[self dropAllTables];
	[self migrate];
}

+ (void)migrate {
	int desiredVersion = [self getSchemaVersion] + 1;

	switch (desiredVersion) {
		case 0:
			[self createSchemaInfoTable];
		case 1:
			[self createDecksTable];
			[self createCardsTable];
	}
	[self updateSchemaVersion:desiredVersion];
}

+ (void)createSchemaInfoTable {
	[self execute:@"create table schema_info (version int);"];
	[self execute:@"insert into schema_info (version) values (-1);"];
}

+ (void)createDecksTable {
	[self execute:@"create table decks (primary_key int, version int, title varchar(100), description varchar(500));"];

	[self execute:@"insert into decks (primary_key, version, title, description) values (1, 1, '2nd Grade Math', 'Second grade math for small children. Mostly simple addition.');"];
	[self execute:@"insert into decks (primary_key, version, title, description) values (2, 1, '3rd Grade Letters', 'First grade math for tots just starting');"];
	[self execute:@"insert into decks (primary_key, version, title, description) values (3, 1, '3rd Grade Reading', 'Third grade reading for small children');"];
}

+ (void)createCardsTable {
	[self execute:@"create table cards (primary_key int, deck_id int, position int, title varchar(200), question text, answer text);"];

	[self execute:@"insert into cards (primary_key, deck_id, position, title, question, answer) values (1, 1, 1, '2 + 3', '<H1>2 + 3</H1>', '<H1>2 + 3 = 5</H1>');"];
	[self execute:@"insert into cards (primary_key, deck_id, position, title, question, answer) values (2, 1, 2, '3 + 6', '<H1>3 + 6</H1>', '<H1>3 + 6 = 9</H1>');"];
	[self execute:@"insert into cards (primary_key, deck_id, position, title, question, answer) values (3, 1, 3, '1 + 7', '<H1>1 + 7</H1>', '<H1>1 + 7 = 8</H1>');"];
}

@end
