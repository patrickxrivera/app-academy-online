require "employee"

class Startup
    attr_accessor :employees, :funding
    attr_reader :name, :salaries

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.key?(title)
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            handle_valid_title(employee_name, title)
        else
            raise KeyError.new("Title doesn't exist.")
        end
    end

    def acquire(startup)
        @funding += startup.funding
        @employees.push(*startup.employees)
        merge_salaries(startup)

        startup.close()
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = @salaries[employee.title]
        
        if salary <= @funding
            employee.pay(salary)
            @funding -= salary
        else
            raise StandardError.new('Not enough funding to pay employee.')
        end
    end

    def payday
        @employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        @employees.reduce(0) { |sum, employee| sum + @salaries[employee.title] } / size.to_f
    end

    def close
        @employees = []
        @funding = 0
    end

    private
    def merge_salaries(startup)
        new_salaries = @salaries.merge(startup.salaries) do |title, ourSalary, theirSalary|
            ourSalary ? ourSalary : theirSalary
        end

        @salaries = new_salaries
    end

    def handle_valid_title(employee_name, title)
        employee = Employee.new(employee_name, title)
        @employees << employee
    end
end
