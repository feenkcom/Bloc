Class {
	#name : #BlStyleExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Style'
}

{ #category : #examples }
BlStyleExamples >> styles [
	<gtExample>
	<return: #BlEagerStyles>
	| styles |
	styles := BlEagerStyles new.

	^ styles
]
