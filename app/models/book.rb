class Book < ActiveRecord::Base
	belongs_to :user_account
	has_one :post, :dependent => :destroy
	has_many :authors, :dependent => :destroy
	has_many :courses, :dependent => :destroy

	accepts_nested_attributes_for :post
	accepts_nested_attributes_for :authors, :allow_destroy => true, :reject_if => :reject_author? 
	accepts_nested_attributes_for :courses, :allow_destroy => true, :reject_if => :reject_course?
	validates :user_account, :title, presence: true
	validate :has_author?, :has_too_many_course?, :has_too_many_author?
	after_save :alert_observers

	ransacker :title_case_insensitive, type: :string do
		Arel.sql('lower(books.title)')
	end

	def reject_author? a
		return false if authors.length == 0
		return (a[:au_lname].blank? and a[:au_fname].blank?)
	end

	def reject_course? c
		return false if courses.length == 0
		return (c[:department].blank? and c[:course_number].blank?)
	end

	def has_author?
		if authors.length == 0 or all_will_be_destroyed authors
			errors.add(:book, "must have at least one author")
			authors.each do |a|
				a.reload if a.marked_for_destruction?
			end
		end
	end

	def has_course?
		if courses.length == 0 or all_will_be_destroyed courses
			errors.add(:book, "must have at least one course")
			courses.each do |c|
				c.reload if c.marked_for_destruction?
			end
		end
	end

	def has_too_many_course?
		if courses.length > 3
			errors.add(:courses, "cannot have more than 3 courses")
		end
	end

	def has_too_many_author?
		if authors.length > 3
			errors.add(:courses, "cannot have more than 3 authors")
		end
	end

	def all_will_be_destroyed arr
		arr.each do |elm|
			return false unless elm.marked_for_destruction?
		end
		return true
	end

	def alert_observers
		Search.where(alert: true).where.not(user_account_id: nil).find_each do |query|
			query.check_for_match self
		end
	end
end
