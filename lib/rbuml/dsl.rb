require 'rbuml/models'
require 'rbuml/dot'


$known_classes = {}


def uml_class(*params)
	cls = RbUMLClass.new(*params)
	if block_given?
		cls.instance_eval { yield }
	end
	$known_classes[cls.name] = cls
end


class RbUMLClass
    def kind(k)
        @kind = k
    end

    def note(text)
        add_note RbUMLNote.new(text)
    end

    def extends(kind)
        add_parent kind
    end

    def implements(kind)
        add_interface kind
    end

    def attribute(*params)
        add_attribute RbUMLAttribute.new(*params)
    end

    def relationship(*params)
        add_relationship RbUMLRelationship.new(*params)
    end

    def method(*params)
        method = RbUMLMethod.new(*params)
        if block_given?
            method.instance_eval { yield }
        end
        add_method method
    end
end


class RbUMLMethod
	def argument(arg)
		add_argument arg
	end
end


def save(filename, format=:png)
	rbuml_dot_render $known_classes, filename, format
end
