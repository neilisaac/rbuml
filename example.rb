#!/usr/bin/env ruby -w -Ilib

require 'rbuml/dsl'

uml_class 'ClassA' do
	implements 'InterfaceI'
	attribute "foo", :int
	attribute "bar", :bool
end

uml_class 'ClassB' do
	extends 'ClassA'
	has 'c', 'ClassC', :private
end

uml_class 'ClassC'

uml_class 'InterfaceI', :interface do
	method 'foo', :string do argument 'bar' end
	method 'plot' do
		argument 'x', :int
		argument 'y', :int
	end
end

uml_class 'EnumE', :enumeration do
	attribute 'zero', 0
	attribute 'one', 1
	attribute 'two', 2
end

save "example.png", :png
