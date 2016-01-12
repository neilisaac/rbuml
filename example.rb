# run with `rbuml example.rb`

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
