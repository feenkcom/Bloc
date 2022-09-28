Class {
	#name : #BlCompositionPainterRepaintingExamples,
	#superclass : #Object,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #'instance creation' }
BlCompositionPainterRepaintingExamples >> scripter [
	<gtExample>
	
	^ BlScripter new
]

{ #category : #'instance creation' }
BlCompositionPainterRepaintingExamples >> scripterElement [
	<gtExample>
	
	^ BCompositionExampleElementWithMultipleLayersAndTransformation new
]
