from sqlalchemy import create_engine
import os
from dataclasses import dataclass
import pandas as pd

@dataclass
class Source:
    name: str
    filepath: str
   

class PrepperLoader:

    SOURCES= (Source(name='web_domains',filepath="/app_data/domains/"),
              Source(name='gcals',filepath="/app_data/gcal/"),)

    def __init__(self):
        PG_USER, PG_PASSWORD, PG_DATABASE = os.environ['POSTGRES_USER'], os.environ["POSTGRES_PASSWORD"], os.environ["POSTGRES_DB"]

        conn_str = f"postgresql+psycopg2://{PG_USER}:{PG_PASSWORD}@database/{PG_DATABASE}"
        engine = create_engine(conn_str)
        self.conn = engine.connect()

    def prep(self)->None:
        self.conn.execute("CREATE SCHEMA IF NOT EXISTS lake")

    def load(self)->None:
        for source in self.SOURCES:
            for files in os.walk(source.filepath):
                root,_,filenames=files
                for filename in filenames:
                    if filename.endswith('.csv'):
                        df=pd.read_csv(os.path.join(root,filename))
                        df['filename']=filename
                        df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_').str.replace('(', '').str.replace(')', '')

                        df.to_sql(  source.name,
                                    self.conn,
                                    schema="lake", 
                                    if_exists="append", 
                                    index=False) 
            

if __name__ == "__main__":
    loader = PrepperLoader()
    loader.prep()
    loader.load()



