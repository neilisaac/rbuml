require 'rbuml'

$known_classes = {}
$current = nil
$method = nil

def uml_class(name, &block)
	$current = RbUMLClass.new(name)
	if block_given?
		block.call $current
	end
	$known_classes[$current.name] = $current
	$current = nil
end


def extends(*params)
	$current.extends(*params)
end


def implements(*params)
	$current.implements *params
end


def attribute(*params)
	$current.attribute *params
end


def has(*params)
	$current.has *params
end


def method(*params, &block)
	$method = RbUMLMethod.new *params
	$current.method $method
	if block_given?
		block.call $method
	end
	$method = nil
end


def argument(*params)
	$method.add_argument RbUMLMethodParam.new(*params)
end


def save(filename, format=:png)
	rbuml_dot_render $known_classes, filename, format
end
