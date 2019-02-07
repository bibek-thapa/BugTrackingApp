require 'test_helper'

class BugTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
	def setup 
	 @bug = Bug.create(titile:"a title",description:"This is the actual description of the bug.",issue_type:2,priority:1,status:0)		end
	






	test "Bug must be valid" do
		assert @bug.valid?
	end

	test "titile must be present" do 
		@bug.titile = "" 
		assert_not @bug.valid?
	end
	test "titile must not be too short" do 
		@bug.titile = "aa" 
		assert_not @bug.valid?
	end

	test "titile must not be too long" do
	       	@bug.titile = "a" * 81 
		assert_not @bug.valid?
	end
	test "description must be present" do 
		@bug.description = "" 
		assert_not @bug.valid?
	end
	test "description must not be too short" do
	       	@bug.description = "aa" 
		assert_not @bug.valid?
	end
	test "description must not be too long" do
		@bug.description = "a" * 601
	       	assert_not @bug.valid?
	end
	 
	 
	test "status must be valid" do 
		invalid_issuetypes = [-10, -1, 3, 10]
	       	invalid_issuetypes.each do |is|
		       	begin
			       	@bug.issue_type = is
			       	assert false, "#{is} should be invalid"
		       	rescue
			       	assert true
		       	end
		       	end
		end
	test "status must be published or unpublished" do 
		valid_issuetypes = [:issue, :enhancement,:feature] 
		valid_issuetypes.each do |is|
		       	begin @bug.issue_type = is 
				assert true
		       	rescue
			       	assert false, "#{is} should be invalid"
		       	end
		       	end
	end 












end
