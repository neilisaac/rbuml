# About

[![Gem Version](https://badge.fury.io/rb/rbuml.svg)](https://badge.fury.io/rb/rbuml)

rbuml is a domain-specific labguage on top of Ruby for generating UML class diagrams using Graphviz dot.

# Installing

On linux and unix-like system, run:

`gem install rbuml`

You will also need to install the graphviz dot utility (ex. `apt-get install graphviz`.)

See [ruby-graphviz](https://github.com/glejeune/Ruby-Graphviz/) for further instructions if you're having trouble.

# Example

Download [example.rb](https://raw.githubusercontent.com/neilisaac/rbuml/master/example.rb) and run `rbuml example.rb`

This should produce "example.png"  containing:

![example image](https://raw.githubusercontent.com/neilisaac/rbuml/master/example.png)

"example.rb":

```
uml_class 'ClassA' do
	attribute "foo", "int"
	attribute "bar", "bool"
	implements 'InterfaceA'
end

uml_class 'ClassB' do
	extends 'ClassA'
	attribute 'c', :ClassC, :private
	relationship 'ClassC', :has
	note <<-eos
		ClassB probably doesn't do much
		with c, but let's have one anyway 
	eos
end

uml_class 'ClassC'

uml_class 'InterfaceA' do
	kind :interface
	method 'add_point', :bool do
		argument 'x', :int
		argument 'y', :int
	end
end

save "example.png"
```
