Class {
	#name : #BlLazyStyles,
	#superclass : #BlAbstractStyles,
	#instVars : [
		'styles'
	],
	#category : #'Bloc-Core-Style'
}

{ #category : #'api - styles' }
BlLazyStyles >> addStyleFor: anElementState computation: aStyleComputation [
	<return: #BlElementStyle>
	| aNewStyle |

	aNewStyle := BlLazyStyle new
		state: anElementState;
		styleComputation: aStyleComputation.
	styles add: aNewStyle.
	^ aNewStyle
]

{ #category : #private }
BlLazyStyles >> clearCache [
	styles do: [ :eachStyle | eachStyle clearCache ]
]

{ #category : #initialization }
BlLazyStyles >> initialize [
	super initialize.

	styles := OrderedCollection new: 10
]

{ #category : #private }
BlLazyStyles >> styles [
	<return: #Collection of: #BlAbstractStyle>

	^ styles
]
