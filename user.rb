# this class deal with users
class User
  USERS = [
    { id: 1, name: 'Laxman', city: 'Pune' },
    { id: 2, name: 'Anil', city: 'Latur' },
    { id: 3, name: 'Satish', city: 'Mumbai' },
    { id: 4, name: 'Prashant', city: 'Udgir' },
    { id: 5, name: 'Laxman', city: 'Delhi' }
  ]

  # return all users
  def self.all
    USERS
  end

  # Find users by id
  def self.find_by_id(id)
    return [] if name.nil?
    USERS.select { |user| user[:id] == id }
  end

  # Find users by name
  def self.find_by_name(name)
    return [] if name.nil?
    USERS.select { |user| user[:name].downcase == name.downcase }
  end
end
