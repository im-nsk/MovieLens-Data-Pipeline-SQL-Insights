import pyodbc
import pandas as pd
import config_file as config


def load_data_without_batch(cursor, conn, file_name_path, sql_insert_query):
    count = 0
    df = pd.read_csv(file_name_path)
    df.dropna(inplace=True)

    for index, value in df.iterrows():
        data = tuple(value)
        cursor.execute(sql_insert_query, data)
        conn.commit()
    table_name = sql_insert_query.split(' ')[2]
    print(f'Data loaded sucessfully from {file_name_path} to {table_name} sql server table')

def load_data(cursor, conn, file_name_path, sql_insert_query):
    batch_size = 1000
    count = 0
    for chunk in pd.read_csv(file_name_path, chunksize=batch_size):
        count = count + 1
        # Remove NaN values from the chunk
        chunk.dropna(inplace=True)
        data = [tuple(row) for row in chunk.values]
        cursor.executemany(sql_insert_query, data)
        conn.commit()
        print(f'chunk count {count} loading completed')
    table_name = sql_insert_query.split(' ')[2]
    print(f'Data loaded sucessfully from {file_name_path} to {table_name} sql server table')

def main():
    server_name = config.credential['database']['server']
    db_name = config.credential['database']['db']
    file_path = config.params['file_path']

    conn_str = f'Driver={{SQL Server}};Server={server_name};Database={db_name};Trusted_Connection=yes;'

    conn = pyodbc.connect(conn_str)
    if conn:
        cursor = conn.cursor()
        print('connected sucessfully\n')
    else:
        print('connection failed')
        exit()

    #movie table
    # movie_data_path = f'{file_path}movies.csv'
    # sql_insert_query = 'INSERT INTO movieLens.movies(movieId,title, genres) VALUES (?, ?, ?)'
    # load_data(cursor, conn, movie_data_path, sql_insert_query)

    # link
    # links_data_path = f'{file_path}links.csv'
    # sql_insert_query = 'INSERT INTO movieLens.links(movieId, imdbId, tmdbId) VALUES (?, ?, ?)'
    # load_data_without_batch(cursor, conn, links_data_path, sql_insert_query)

    # genome_tags_df
    # genome_tags_data_path = f'{file_path}genome-tags.csv'
    # sql_insert_query = 'INSERT INTO movieLens.genome_tags(tagId, tag) VALUES (?, ?)'
    # load_data(cursor, conn, genome_tags_data_path, sql_insert_query)

    # genome_scores
    genome_scores_data_path = f'{file_path}genome-scores.csv'
    sql_insert_query = 'INSERT INTO movieLens.genome_scores(movieId, tagId, relevance) VALUES (?, ?, ?)'
    load_data(cursor, conn, genome_scores_data_path, sql_insert_query)

    # tags_df
    # tags_data_path = f'{file_path}tags.csv'
    # sql_insert_query = 'INSERT INTO movieLens.tags(userId, movieId, tag, timestamp) VALUES (?, ?, ?, ?)'
    # load_data(cursor, conn, tags_data_path, sql_insert_query)

    # ratings_df
    # ratings_data_path = f'{file_path}ratings.csv'
    # sql_insert_query = 'INSERT INTO movieLens.rating(userId, movieId, rating, timestamp) VALUES (?, ?, ?, ?)'
    # load_data(cursor, conn, ratings_data_path, sql_insert_query)

    cursor.close()
    conn.close()

if __name__ == '__main__':
    main()


