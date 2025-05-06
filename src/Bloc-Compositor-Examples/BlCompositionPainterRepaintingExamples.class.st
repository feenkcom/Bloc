Class {
	#name : #BlCompositionPainterRepaintingExamples,
	#superclass : #Object,
	#category : #'Bloc-Compositor-Examples'
}

{ #category : #'instance creation' }
BlCompositionPainterRepaintingExamples >> scripter [
	<gtExample>
	<return: #BlScripter>
	^ BlScripter new
]

{ #category : #'instance creation' }
BlCompositionPainterRepaintingExamples >> scripterElement [
	<gtExample>
	<return: #BCompositionExampleElementWithMultipleLayersAndTransformation>
	^ BCompositionExampleElementWithMultipleLayersAndTransformation new
]
