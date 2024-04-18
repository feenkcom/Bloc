Class {
	#name : #BlDevScripterDoItReference,
	#superclass : #BlDevScripterReference,
	#instVars : [
		'compiledMethod',
		'interval'
	],
	#category : #'Bloc-Scripter-Scripter-Properties'
}

{ #category : #'gt-extension' }
BlDevScripterDoItReference >> compiledMethod [
	^ compiledMethod
]

{ #category : #private }
BlDevScripterDoItReference >> compiledMethod: aCompiledMethod [
	compiledMethod := aCompiledMethod
]

{ #category : #'gt-extension' }
BlDevScripterDoItReference >> gtReferenceFor: aView [
	<gtView>
	self compiledMethod ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Source';
		priority: 5;
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ :aButton | aButton phlow spawnTool: (GtMethodCoderTool compiledMethod: self compiledMethod) ];
		stencil: [ ((GtPharoSnippetCoder forSource: self compiledMethod sourceCode)
				in: [ :theCoder | 
					theCoder addOns
						addStyler: (GtPharoInterestingIntervalStyler new interval: interval) ];
				asExpandedOnlyElement) vFitContentLimited ]
]

{ #category : #private }
BlDevScripterDoItReference >> interval: anInterval [
	interval := anInterval
]
