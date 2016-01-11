require 'graphviz'

require 'rbuml/models'


def rbuml_dot_render(classes, filename, format=:png)
	g = GraphViz.new(:G, :type => :digraph, :ratio => :compress)
	
	classes.each do |name, cls|
		g.add_nodes(cls.name, :label => cls.dot_label, :shape => "record")
	end
	
	classes.each do |name, cls|
		cls.notes.each_with_index do |note,i|
			g.add_nodes("note#{cls.name}#{i}", :label => note.dot_label, :shape => :note)
			g.add_edges(cls.name, "note#{cls.name}#{i}", :dir => :none)
		end
	end
	
	classes.each do |name, cls|
		cls.interfaces.each do |inter|
			g.add_edges(cls.name, inter, :arrowhead => :empty)
		end
		
		cls.parents.each do |parent|
			g.add_edges(cls.name, parent, :arrowhead => :empty)
		end
		
		cls.relationships.each do |rel|
			g.add_edges(cls.name, rel.kind, :label => rel.dot_label, :dir => :both, :arrowhead => :none, :arrowtail => :odiamond, :headlabel => rel.head_label)
		end
	end
	
	g.output(format => filename)
	puts "saved " + filename
end


class RbUMLClass
	def dot_label
		kind_lookup = {
			:class => "",
			:enumeration => "&lt;&lt;enumeration&gt;&gt;\n",
			:interface => "&lt;&lt;interface&gt;&gt;\n",
		}
		attributes = @attributes.collect { |a| a.dot_label }.join('\l')
		methods = @methods.collect { |m| m.dot_label }.join('\l')
		"{#{kind_lookup[@kind]}#{@name}|#{attributes}\\l|#{methods}\\l}"
	end
end


class RbUMLAttribute
	def dot_label
		visibility_lookup = {
			:unspecified => '',
			:public => '+',
			:private => '-',
			:protected => '#',
			:derived => '/',
			:package => '~',
		}
		kind = @kind ? " : #{@kind.to_s}" : ""
		"#{visibility_lookup[@visibility]}#{@name}#{kind}"
	end
end


class RbUMLRelationship
	def dot_label
		@verb ? "&lt;&lt;#{@verb}&gt;&gt;" : ''
	end
	
	def head_label
		@multiplicity ? @multiplicity : ''
	end
end


class RbUMLMethod
	def dot_label
		visibility_lookup = {
			:unspecified => '',
			:public => '+',
			:private => '-',
			:protected => '#',
			:derived => '/',
			:package => '~',
		}
		args = @arguments.collect { |p| p.dot_label }.join(', ')
		kind = @returns ? " : #{@returns}" : ""
		"#{visibility_lookup[@visibility]}#{@name}(#{args})#{kind}"
	end
end


class RbUMLMethodArgument
	def dot_label
		@kind ? "#{@name} : #{@kind}" : "#{@name}"
	end
end


class RbUMLNote
	def dot_label
		@text.split("\n").collect {|line| line.gsub("\t", '') }.join('\l') + '\l'
	end
end
