require_relative "entry.rb"
require "csv"

class AddressBook
   attr_accessor :entries
   
   def initialize
      @entries = []
   end

   def add_entry(name, phone, email)
      index = 0
       
      @entries.each do |entry|
         if name < entry.name
            break
         end
         
         index += 1
      end
       
      @entries.insert(index, Entry.new(name, phone, email))
   end

   def remove_entry
      @entries.delete(@entries.last)
   end
   
   def import_from_csv(file_name)
      csv_text = File.read(file_name)
      csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
      
      csv.each do |row|
         row_hash = row.to_hash
         add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
      end
   end
   # Search AddressBook for a specific entry by name (binary search)
   #
   # Note: This Bloc checkpoint does not mention that a binary search algorithm
   # is performed on a sorted collection. It so happens that the 'entries.csv'
   # are in fact lexicographically sorted. However, the AddressBook class would
   # benefit for a method that sorts an unsorted collection.
   def binary_search(name)
      lower = 0
      upper = entries.length - 1
      
      while lower < upper
         mid = (lower + upper) / 2
         mid_name = entries[mid].name
         
         if name == mid_name
            return entries[mid]
         elsif name < mid_name
            upper = mid - 1
         elsif name > mid_name
            lower = mid + 1
         end
      end

      return nil
   end

   # Search AddressBook for a specific entry by name (linear search)
   #
   # Note: The Bloc checkpoint uses a misnomer when calling this method
   # 'iterative_search'. Judging from the assigment, I assume the intent is to
   # define a linear search.
   #
   # The two main search categories are 'iterative' and 'recursive'. The
   # 'binary_search' is iterative in that it repetiviely executes a series of
   # of code until some conditional statement is met. A recursive search first
   # establishes a base case, which is analogous to an iterative search's
   # conditional statem, and then embeds a method call to itself (i.e., it
   # recurses) until the base case is met.
   def iterative_search(name)
      entries.each do |item|
         if (item == name)
            result = entries[item]
         else
            result = nil
         end
      end
         
      return result
   end
end