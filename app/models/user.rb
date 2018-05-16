class User < ActiveRecord::Base
  serialize :sources
  serialize :results
  serialize :comments
end
