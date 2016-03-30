require 'jbundler'
require 'java'

java_import "org.slf4j.LoggerFactory"
java_import "org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender"
java_import "org.apache.mahout.cf.taste.impl.model.file.FileDataModel"
java_import "org.apache.mahout.cf.taste.impl.neighborhood.ThresholdUserNeighborhood"
java_import "org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity"

model = FileDataModel.new(java.io.File.new('./dataset.csv'))
similarity = PearsonCorrelationSimilarity.new(model)
neighborhood = ThresholdUserNeighborhood.new(0.1, similarity, model)

recommender = GenericUserBasedRecommender.new(model, neighborhood, similarity)

recommendations = recommender.recommend(2, 3)

puts recommendations.inspect
recommendations.each {|r| puts r}
