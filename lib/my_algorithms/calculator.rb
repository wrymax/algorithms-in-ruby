module MyAlgorithms
  class Calculator

    Priority = {
      '+' => 1, 
      '-' => 1, 
      '*' => 2, 
      '/' => 2
    }
    def initialize
    end

    def run(expr)
      rpn_expr = rpn(expr)
      exec(rpn_expr)
    end

    private

    # reverse polish notation
    def rpn(expr)
      stack = []
      ret = []
      expr = preprocess(expr)
      expr.each do |i|
        char = i
        if char == ' '
          next
        else
          if number?(char)
            ret << char
          else
            if char == '('
              stack << char
            elsif char == ')'
              flag = true
              while flag
                if stack[-1] == '('
                  flag = false
                  stack.pop
                else
                  ret << stack.pop
                end
              end
            else
              # + - * /
              if stack.empty?
                stack << char
              elsif parenthesis?(stack[-1])
                stack << char
              elsif Priority[char] <= Priority[stack[-1]]
                flag = true
                while flag
                  if stack.empty? || parenthesis?(stack[-1]) || Priority[stack[-1]] < Priority[char]
                    flag = false
                  else
                    ret << stack.pop
                  end
                end
                stack << char
              else
                stack << char
              end
            end
          end
        end
      end
      while stack[-1]
        ret << stack .pop
      end
      ret
    end

    def exec(expr)
      stack = []
      expr.each do |i|
        if number?(i)
          stack << i
        elsif operator?(i)
          negative = stack.pop
          positive = stack.pop
          val = positive.to_f.send(i, negative.to_f)
          stack << val
        else
          raise Exception, "Something wrong with reverse polish notation."
        end
      end
      stack.pop
    end

    def number?(str)
      str.match /^[0-9]*\.{0,1}[0-9]*$/
    end

    def operator?(str)
      ['+', '-', '*', '/'].include? str
    end

    def parenthesis?(str)
      ['(', ')'].include? str
    end

    def type(char)
      if number?(char)
        'number'
      elsif operator?(char)
        'operator'
      elsif parenthesis?(char)
        'parenthesis'
      else
        raise Exception, "expression error, please use number and math operators"
      end
    end

    def preprocess(expr)
      expr = expr.gsub(/\s/,'').scan(/([0-9]+\.{0,1}[0-9]*)|([\+\-\*\/\(\)]{1})/).map{|x| x.compact![0]}
    end
  end
end
