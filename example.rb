#!/usr/bin/env ruby

$:.unshift("lib")
require 'rbuml/dsl'

uml_class 'ClassA' do
	attribute "foo", "int"
	attribute "bar", "bool"
	implements 'InterfaceA'
end

uml_class 'ClassB' do
	extends 'ClassA'
	has 'c', 'ClassC', :private
end

uml_class 'ClassC'

uml_class 'InterfaceA' do
	method 'plot' do
		argument 'x', :int
		argument 'y', :int
	end
end

save "example.png"
