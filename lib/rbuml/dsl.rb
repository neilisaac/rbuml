require 'rbuml/models'
require 'rbuml/dot'

$known_classes = {}
$current = nil
$method = nil

def uml_class(*params, &block)
	$current = RbUMLClass.new(*params)
	if block_given?
		block.call $current
	end
	$known_classes[$current.name] = $current
	$current = nil
end


def kind(k)
	$current.kind = k
end


def note(text)
	$current.add_note RbUMLNote.new(text)
end


def extends(kind)
	$current.add_parent kind
end


def implements(kind)
	$current.add_interface kind
end


def attribute(*params)
	$current.add_attribute RbUMLAttribute.new(*params)
end


def relationship(*params)
	$current.add_relationship RbUMLRelationship.new(*params)
end


def method(*params, &block)
	$method = RbUMLMethod.new(*params)
	if block_given?
		block.call $method
	end
	$current.add_method $method
	$method = nil
end


def argument(*params)
	$method.add_argument RbUMLMethodArgument.new(*params)
end


def save(filename, format=:png)
	rbuml_dot_render $known_classes, filename, format
end
