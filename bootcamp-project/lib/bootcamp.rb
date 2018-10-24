class Bootcamp
    attr_accessor :teachers, :students, :grades
    attr_reader :name, :slogan, :student_capacity, :student_to_teacher_ratio
    
    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new { |hash, key| hash[key] = [] }
    end

    public
    def hire(teacher)
        @teachers << teacher
    end

    def enroll(student)
        if under_capacity? 
            @students << student
            true
        else
            false
        end
    end

    def enrolled?(student)
        @students.include?(student)
    end

    def student_to_teacher_ratio
        (@students.length / @teachers.length).floor
    end

    def add_grade(student, grade)
        is_enrolled = students.include?(student)
        @grades[student] << grade if is_enrolled
        is_enrolled
    end

    def num_grades(student)
        @grades[student].length
    end

    def average_grade(student)
        return nil if !students.include?(student) || !@grades[student].any?
        
        sum = @grades[student].reduce { |sum, grade| sum + grade }
        count = @grades[student].length
        
        sum / count
    end

    private
    def under_capacity?
        @students.length < @student_capacity
    end
end
