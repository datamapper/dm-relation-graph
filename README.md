# Relation Graph

[![BuildStatus](https://secure.travis-ci.org/datamapper/dm-relation-graph.png?branch=master)](http://travis-ci.org/datamapper/dm-relation-graph)
[![DependencyStatus](https://gemnasium.com/datamapper/dm-relation-graph.png)](https://gemnasium.com/datamapper/dm-relation-graph)
[![CodeClimate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/datamapper/dm-relation-graph)

# API (not yet implemented, open for suggestions, RDD style)

``` ruby
graph = DataMapper::Relation::Graph.new do

  base_relation :people do

    # only base relations nodes expose this method
    #
    repository :postgres

    attribute :id,        Integer
    attribute :parent_id, Integer
    attribute :name,      String
    attribute :birthday,  Date

    key id

    # creates an instance of Reference and a
    # corresponding many_to_one relationship
    #
    # aliased to #many_to_one
    reference :parent, parent_id => id

    one_to_one :profile, profiles.reference(:person)

    one_to_many :children, reference(:parent)

    # arbitrary params can be passed to the block in order
    # to be able to compose parameterized scopes. this is
    # true for all relationship types, not only one_to_many
    one_to_many :teenagers, reference(:parent) do |date|
      restrict { |r| r.birthday.lte(date) }
    end

    one_to_many :addresses, addresses.reference(:person)

    # through relationship exists

    one_to_many :links_to_followers, people_links.reference(:followed)

    many_to_many :followers do

      # if the given parameter is a symbol,
      # lookup the corresponding relationship.
      #
      # passing a reference as first parameter
      # implies going through a one_to_many
      # relationship that may or may not exist.
      #
      # if it doesn't exist, the necessary
      # information to peform the join, is
      # retrieved from the given reference
      # (which essentially is the many_to_one
      # relationship on the "virtual" one_to_many
      # relationship's target end.
      #
      through :links_to_followers do
        # some fancy operation
      end

      # The same constraints as with #through
      # apply also for the #via method.
      #
      via people_links.reference(:follower) do
        # some fancy operation
        #
        # passing a block will raise an error
        # if the given parameter is a reference,
        # as this implies going via a many_to_one
        # relationship and it makes no sense to
        # apply any further operations to that as
        # it points to a uniquely identified tuple.
        #
        # obviously, for the given example, that
        # error would be raised.
      end

      apply do |some, optional, params, here|
        # some fancy operation on the joined relation
      end
    end

    # through relationship does not exist

    many_to_many :followed_people do
      through people_links.reference(:follower)
      via people_links.reference(:followed)
    end
  end

  base_relation :addresses do

    repository :postgres

    attribute :id,        Integer
    attribute :person_id, Integer
    attribute :street,    String

    key id

    reference :person, person_id => people.id
  end

  base_relation :profiles do

    repository :postgres

    attribute :id,        Integer
    attribute :person_id, Integer
    attribute :nickname,  String

    key id

    reference :person, person_id => people.id
  end

  base_relation :people_links do

    repository :postgres

    attribute :follower_id, Integer
    attribute :followed_id, Integer

    key follower_id, followed_id

    reference :follower, follower_id => people.id
    reference :followed, followed_id => people.id
  end

  # register arbitrary relations and give them a name.
  #
  relation :people_with_profiles do
    people.join(profiles, profiles.reference(:person))
  end
end

graph.finalize

people    = graph[:people]
addresses = graph[:addresses]

# return tuples as illustrated by this array of hashes.
# A real implementation would most likely yield (ordered)
# sets containing veritas tuple objects.
#
# [
#   {
#     :id        => 1,
#     :name      => 'John',
#     :addresses => [
#       {
#         :id        => 1,
#         :person_id => 1,
#         :street    => '@home'
#       }
#     ]
#   }
# ]
relation = people.include(:addresses)

# The following explicit join represents an equivalent relation
relation = people.join(addresses, addresses.reference(:person))

# The idea behing the #query method accepting a block
# is that we can instance_eval in a special evaluator
# context that responds to all registered relation names,
# returning the relation named by the sent method name.
#
# when invoked with no arguments and only a block,
# an "anonymous" relation will be created, and it won't
# be stored in the graph.
relation = graph.relation do

  # no need to define variables for people and addresses

  people.include(:addresses)

  # The following explicit join represents an equivalent relation
  # It would be rather inconvenient to write outside of the block's
  # evaluator context, as it would involve either using Graph#[]
  # multiple times or introducing (local) variables (as shown above)
  people.join(addresses, addresses.reference(:person))
end

relation.to_a.each do |tuple|
  # ...
end
```
