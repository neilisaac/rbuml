class RbUMLClass
	attr_reader :name
	attr_reader :parents
	attr_reader :interfaces
	attr_reader :relationships
	attr_reader :notes
	attr_writer :kind

	def initialize(name, kind=:class)
		@name = name
		@parents = []
		@interfaces = []
		@attributes = []
		@relationships = []
		@methods = []
		@notes = []
		@kind = kind
	end

	def add_parent(cls)
		@parents << cls
	end

	def add_interface(inter)
		@interfaces << inter
	end

	def add_attribute(attrib)
		@attributes << attrib
	end

	def add_relationship(rel)
		@relationships << rel
	end

	def add_method(method)
		@methods << method
	end

	def add_note(note)
		@notes << note
	end
end


class RbUMLAttribute
	attr_reader :kind

	def initialize(name, kind, visibility=:unspecified)
		@name = name
		@kind = kind
		@visibility = visibility
	end
end


class RbUMLRelationship
	attr_reader :kind

	def initialize(kind, verb=nil, multiplicity=nil)
		@kind = kind
		@verb = verb
		@multiplicity = multiplicity
	end
end


class RbUMLMethod
	attr_reader :name
	attr_reader :note

	def initialize(name, returns=nil, visibility=:unspecified)
		@name = name
		@returns = returns
		@arguments = []
		@visibility = visibility
	end

	def add_argument(arg)
		@arguments << arg
	end
end


class RbUMLMethodArgument
	attr_reader :name
	attr_reader :kind

	def initialize(name, kind=nil)
		@name = name
		@kind = kind
	end
end


class RbUMLNote
	def initialize(text)
		@text = text
	end
end
