Class {
	#name : #BrStencilBuilder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'executor'
	],
	#category : #'Bloc-Core-Stencil'
}

{ #category : #accessing }
BrStencilBuilder class >> stencilProperties [
	"Return a list of inst.var names that play a role of the persistent stencil properties.
	It can be overriden by subclasses for debugging and architectural constaint reasons.
	Stencil parameters are like function arguments - they are set right before a #build method is called,
	while stencil properties are set once at the time of the stencil creation.
	Stencil properties are usually those inst.vars that do not appear in #paramsOn:"

	^ #()
]

{ #category : #'api - converting' }
BrStencilBuilder >> asElement [
	"Build a corresponding stencil and ask it to create and return a new element"
	<return: #BlElement>
	
	^ self build asElement
]

{ #category : #'api - converting' }
BrStencilBuilder >> asStencilBuilder [
	<return: #BrStencilBuilder>

	^ self
]

{ #category : #'api - converting' }
BrStencilBuilder >> asStencilBuilder: aStencilBuilderClass [
	<return: #BrStencilBuilder>

	^ self
]

{ #category : #building }
BrStencilBuilder >> build [
	<return: #BrStencil>
	| anExecutor aResult |
	
	anExecutor := executor.
	anExecutor resetArguments.
	self paramsOn: anExecutor.
	aResult := anExecutor execute.
	
	anExecutor resetArguments.
	self reset.
	^ aResult
]

{ #category : #'api - instantiation' }
BrStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>

	^ self subclassResponsibility
]

{ #category : #accessing }
BrStencilBuilder >> executor: aBrStencilExecutor [
	self
		assert: [ aBrStencilExecutor isNotNil ]
		description: [ 'Executor must not be nil' ].
	
	executor := aBrStencilExecutor
]

{ #category : #initialization }
BrStencilBuilder >> initialize [
	super initialize.
	
	executor := BrStencilDefaultExecutor new stencil: self
]

{ #category : #'api - instantiation' }
BrStencilBuilder >> paramsOn: aStencilExecutor [
]

{ #category : #initialization }
BrStencilBuilder >> reset [
	"Is called after the #build to de-reference dynamic parameters passed
	by the called of the build"
]

{ #category : #printing }
BrStencilBuilder >> storeOn: aStream [
	aStream store: executor.
	aStream space.
	aStream nextPutAll: #asStencilBuilder: asString.
	aStream space.
	aStream nextPutAll: self class name.
]
