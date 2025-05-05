"
I show a more complex example of how multiple children can be aligned within a parent element that uses {{gtClass:BlFrameLayout}}.

The parent contains three children, yellow, green and red added in the same order. Yellow matches completely the parent. The green and red children have a fixed size and different alignments. We can see that red is overlayed on top of the green child, and both green and red are overlayed on top of the yellow child. This is the case as children are rendered in the other in which they were added to the parent.

{{gtExample:BlFrameLayoutCompositionExamples>>#example|previewExpanded|previewHeight=450}}

In case we add children in the reverse order, red, green and yellow, we just see the yellow child, as it takes the entire available space and it overlaps both the other children.

{{gtExample:BlFrameLayoutCompositionExamples>>#exampleReverseOrder|previewExpanded|previewHeight=450}}

"
Class {
	#name : #BlFrameLayoutCompositionExamples,
	#superclass : #BlFrameLayoutExamples,
	#category : #'Bloc-Layout-Examples-Frame'
}

{ #category : #'instance creation' }
BlFrameLayoutCompositionExamples >> container [
	<gtExample>
	<return: #BlElement>
	^ self element
		padding: (BlInsets all: 10);
		background: Color blue
]

{ #category : #'instance creation' }
BlFrameLayoutCompositionExamples >> element [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
]

{ #category : #example }
BlFrameLayoutCompositionExamples >> example [
	<gtExample>
	<return: #BlElement>
	| yellow green red container |
	yellow := self yellow
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	green := self green
			size: 200 @ 200;
			constraintsDo: [ :c | 
				c frame horizontal alignRight.
				c frame vertical alignBottom ].

	red := self red
			size: 100 @ 100;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ].

	container := self container
			layout: BlFrameLayout new;
			size: 350 @ 350;
			relocate: 200 @ 100;
			addChildren: {yellow.
					green.
					red}.

	^ container
]

{ #category : #example }
BlFrameLayoutCompositionExamples >> exampleReverseOrder [
	<gtExample>
	<return: #BlElement>
	| yellow green red container |
	yellow := self yellow
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].

	green := self green
			size: 200 @ 200;
			constraintsDo: [ :c | 
				c frame horizontal alignRight.
				c frame vertical alignBottom ].

	red := self red
			size: 100 @ 100;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ].

	container := self container
			layout: BlFrameLayout new;
			size: 350 @ 350;
			relocate: 200 @ 100;
			addChildren: {red.
					green.
					yellow}.

	^ container
]

{ #category : #'instance creation' }
BlFrameLayoutCompositionExamples >> green [
	<gtExample>
	<return: #BlElement>
	^ self element
		background: Color green;
		border: (BlBorder paint: Color black width: 4)
]

{ #category : #'instance creation' }
BlFrameLayoutCompositionExamples >> red [
	<gtExample>
	<return: #BlElement>
	^ self element
		background: Color red;
		border: (BlBorder paint: Color lightGray width: 4)
]

{ #category : #'instance creation' }
BlFrameLayoutCompositionExamples >> yellow [
	<gtExample>
	<return: #BlElement>
	^ self element
		background: Color yellow;
		border: (BlBorder paint: Color darkGray width: 4)
]
