require 'graphviz'


class RbUMLClass
	attr_reader :name
	attr_reader :parents
	attr_reader :interfaces
	attr_reader :references
	
	def initialize(name)
		@name = name
		@parents = []
		@interfaces = []
		@attributes = []
		@references = []
		@methods = []
	end
	
	def extends(cls)
		@parents << cls
	end
	
	def implements(inter)
		@interfaces << inter
	end
	
	def attribute(name, kind, visibility=:public)
		@attributes << RbUMLAttribute.new(name, kind, visibility)
	end
	
	def has(name, kind, visibility=:public)
		m = RbUMLAttribute.new(name, kind, visibility)
		@attributes << m
		@references << m
	end
	
	def method(method)
		@methods << method
	end
	
	def dot_label
		attributes = @attributes.collect { |a| a.dot_label }.join('\l')
		methods = @methods.collect { |m| m.dot_label }.join('\l')
		"{#{@name}|#{attributes}|#{methods}}"
	end
end


class RbUMLAttribute
	attr_reader :kind
	
	def initialize(name, kind, visibility=:public)
		@name = name
		@kind = kind
		@visibility = visibility
	end
	
	def dot_label
		lookup = {
			:public => '+',
			:private => '-',
			:protected => '#',
			:derived => '/',
			:package => '~',
		}
		repr = lookup[@visibility] + ' ' + @name
		if @kind
			repr += ' : ' + @kind.to_s
		end
		repr
	end
end


class RbUMLMethod
	attr_reader :name
	attr_reader :note
	
	def initialize(name, returns=nil)
		@name = name
		@returns = returns
		@arguments = []
	end
	
	def add_argument(arg)
		@arguments << arg
	end
	
	def dot_label
		args = @arguments.collect { |p| p.dot_label }.join(', ')
		kind = @returns ? " : #{@returns}" : ""
		"#{@name}(#{args})#{kind}"
	end
end


class RbUMLMethodParam
	attr_reader :name
	attr_reader :kind
	
	def initialize(name, kind=nil)
		@name = name
		@kind = kind
	end
	
	def dot_label
		@kind ? "#{@name} : #{@kind}" : "#{@name}"
	end
end


def rbuml_dot_render(classes, filename, format=:png)
	g = GraphViz.new(:G, :type => :digraph)
	
	classes.each do |name, cls|
		g.add_nodes(cls.name, :label => cls.dot_label, :shape => "record")
	end
	
	classes.each do |name, cls|
		cls.interfaces.each do |inter|
			g.add_edges(cls.name, inter, :arrowhead => :empty)
		end
		
		cls.parents.each do |parent|
			g.add_edges(cls.name, parent, :arrowhead => :empty)
		end
		
		cls.references.each do |ref|
			g.add_edges(cls.name, ref.kind, :arrowhead => :normal, :arrowtail => :obox)
		end
	end
	
	g.output(format => filename)
	puts "saved " + filename
end
