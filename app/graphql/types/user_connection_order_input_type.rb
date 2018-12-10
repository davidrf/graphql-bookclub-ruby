class Types::UserConnectionOrderInputType < Types::BaseInputObject
  argument :direction, Types::OrderDirectionType, required: true
  argument :field, Types::UserConnectionOrderFieldType, required: true
end