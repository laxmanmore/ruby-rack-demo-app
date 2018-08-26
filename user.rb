class User
  USERS = {
    1 => { name: 'Laxman', city: 'Pune' },
    2 => { name: 'Anil', city: 'Latur' },
    3 => { name: 'Satish', city: 'Mumbai' },
    4 => { name: 'Prashant', city: 'Udgir' }
  }

  def self.all
    USERS
  end

  def self.find_by_id(id)
    USERS[id]
  end
end