from pyspark.sql import SparkSession
from pyspark.sql.functions import avg, count, stddev, round as round_
import time

spark = (SparkSession.builder
         .appName("MovieLensAggregate")
         .master("local[*]")
         .getOrCreate())
spark.sparkContext.setLogLevel("WARN")
start = time.time()

ratings = spark.read.csv("../dataset/rating.csv", header=True, inferSchema=True)
ratings = ratings.select("movieId", "rating")


perMovie = ratings.groupBy("movieId").agg(
    round_(avg("rating"), 5).alias("avg_movie_rating"),
    count("rating").alias("rating_count"),
    round_(stddev("rating"), 6).alias("rating_std"),
)

movieCount = perMovie.count()
print(f"Shrunk 20,000,263 ratings -> {movieCount:}")

perMovie.orderBy("movieId").toPandas().to_csv("spark_movie_agg.csv", index=False)
spark.stop()
