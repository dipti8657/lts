class Setup < ActiveRecord::Base

attr_accessible :total_leaves, :year

  def self.get_remaining_leave
    remaining_leaves = self.total_leaves - @leaves_taken
    return remaining_leaves
  end

  def self.total_leave
    #connection = ActiveRecord::Base.connection();
    #query = ("select total_leaves from setups where year = '#{Time.now.year}'")

    #result = connection.execute(query)
    result = Setup.find_by_sql ("select total_leaves from setups where year = '#{Time.now.year}' ")
    #result = Setup.select("total_leaves").where(:year => "#{Time.now.year}%")

    return result
  end

end
