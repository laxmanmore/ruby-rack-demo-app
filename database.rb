# database class
class Database
  USERS = {
    1 => { name: 'Laxman' },
    2 => { name: 'Anil' },
    3 => { name: 'Satish' },
    4 => { name: 'Prashant' }
  }

  def self.users
    USERS
  end
end