class Pokemon
  
  attr_accessor :id, :name, :type, :db

  def initialize(name:, type:, id:, db:)
    @name = name
    @type = type
    @id = id
    @db = db
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon(name, type) VALUES (?,?)", name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id,db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
      LIMIT 1
    SQL
  
    db.execute(sql, id).map do |row|
      new_pokemon = self.new(id: row[0], name: row[1], type: row[2], db: db)  
      new_pokemon
    end.first
  end 
  
end
