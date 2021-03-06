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

   def remove_entry(name, phone, email)
      @entries.each do |entry|
         if (entry.name == name && entry.phone_number == phone && entry.email == email)
            @entries.delete(entry)
         end
      end
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
   def binary_search(name)
      lower = 0
      upper = entries.length - 1
      
      while lower <= upper
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
   #
   # The 'iterative_search' method is in fact a linear search (O(n) time), and
   # the method is defined iteratively and not recursively. Again, both this
   # method and the 'binary_search' method apply an iterative approach.
   def iterative_search(name)
      result = nil
      
      entries.each do |item|
         if (item.name == name)
            result = item
            break
         else
            result = nil
         end
      end
         
      return result
   end
   
=begin
   Checkpoint #24 Question...
   
   Which algorithm is more efficient: binary search, or iteration? How do you
   know? How might you measure the difference?
   
   Answer...
   
   On a sorted collection, a binary search is more efficient than 'iteration'.
   'Iteration' is a misnomer. I believe the intent of this question is to make
   a distinction between a binary search and a linear search. A binary search is
   executed in O(log n) time, whereas a linear serch is executed in O(n) time.
   Hence, a binary search is more efficient in time.
=end
end