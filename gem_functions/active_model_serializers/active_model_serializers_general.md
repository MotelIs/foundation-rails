#ACTIVE MODEL SERIALIZERS: Bringing convention over configuration to your JSON generation.

[link][1]

#OVERVIEW
2 components:
  -SERIALIZERS describe
    WHICH attributes and relationships should be serialized
  -ADAPTERS describe
    HOW attributes and relationships should be serialized

#CREATE
Resource generates a model and serializer at the same time:
`$ rails g resource post name:string body:string`

Add a serializer for an existing model:
`$ rails g serializer post`

#INHERITANCE
The generated serializer will contain attributes inherited from
the model

#ATTRIBUTES
class CommentSerializer < ActiveModel::Serializer
  `attributes :name, :body

  belongs_to :post_id

  url [:post, :comment]
end`

The attribute names are a *whitelist* of attributes to be serialized.
By default, when you serialize Post, you also get Comments

#CUSTOM SERIALIZING
you can use the "serializer" option to specify a custom serializer class:

`has_many :comments, serializer: CommentPreviewSerializer`

[1]: https://github.com/rails-api/active_model_serializers
