Class {
	#name : #BlEnqueuedFutureAction,
	#superclass : #BlTask,
	#instVars : [
		'action',
		'resultCallbacks',
		'exceptionCallbacks',
		'element',
		'name',
		'futureConfiguration'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #accessing }
BlEnqueuedFutureAction >> action [
	^ action
]

{ #category : #accessing }
BlEnqueuedFutureAction >> action: anAction [
	action := anAction asAsyncFuture
]

{ #category : #initialization }
BlEnqueuedFutureAction >> defaultFutureConfiguration [
	^ AsyncFutureExecutionConfiguration new customGroup: #UI
]

{ #category : #accessing }
BlEnqueuedFutureAction >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlEnqueuedFutureAction >> element: aBlElement [
	element := aBlElement
]

{ #category : #'api - running' }
BlEnqueuedFutureAction >> enqueuePromise: aPromise [
	self element ifNotNil: [ :anElement | 
		anElement enqueueTask: (BlPromiseTask new promise: aPromise) ]
]

{ #category : #accessing }
BlEnqueuedFutureAction >> futureAction [
	^ self action
]

{ #category : #accessing }
BlEnqueuedFutureAction >> futureConfiguration [
	<return: #AsyncFutureExecutionConfiguration>
	^ futureConfiguration ifNil: [ 
		futureConfiguration := self defaultFutureConfiguration ]
]

{ #category : #accessing }
BlEnqueuedFutureAction >> futureConfiguration: aAsyncFutureExecutionConfiguration [
	futureConfiguration := aAsyncFutureExecutionConfiguration
]

{ #category : #initialization }
BlEnqueuedFutureAction >> initialize [
	super initialize.
	self action: [ ].
	resultCallbacks := OrderedCollection new.
	exceptionCallbacks := OrderedCollection new.
]

{ #category : #accessing }
BlEnqueuedFutureAction >> name [
	^ name
]

{ #category : #accessing }
BlEnqueuedFutureAction >> name: anObject [
	name := anObject
]

{ #category : #hooks }
BlEnqueuedFutureAction >> onEnqueuedInElement: aBlElement [
	self element: aBlElement
]

{ #category : #'api - callbacks' }
BlEnqueuedFutureAction >> onFailureDo: aCallback [
	exceptionCallbacks add: aCallback
]

{ #category : #'api - callbacks' }
BlEnqueuedFutureAction >> onFailureEnqueueAction: aCallback [
	self onFailureDo: [ :aResult | 
		self element enqueueTask: ((BlTaskAction new 
			action: [ aCallback cull: aResult cull: self ]) 
				asBeaconLoggingTask maySetName: 'Failure Action') ]
]

{ #category : #'api - callbacks' }
BlEnqueuedFutureAction >> onFinishEnqueueAction: aCallback [
	self onFinishedDo: [ :aResultOrException | 
		self element enqueueTask: ((BlTaskAction new 
			action: [ aCallback cull: aResultOrException cull: self ]) 
				asBeaconLoggingTask maySetName: 'Finish Action') ]
]

{ #category : #'api - callbacks' }
BlEnqueuedFutureAction >> onFinishedDo: aCallback [
	self onSuccessDo: aCallback.
	self onFailureDo: aCallback.
]

{ #category : #'api - callbacks' }
BlEnqueuedFutureAction >> onSuccessDo: aCallback [
	resultCallbacks add: aCallback
]

{ #category : #'api - callbacks' }
BlEnqueuedFutureAction >> onSuccessEnqueueAction: aCallback [
	self onSuccessDo: [ :aResult | 
		self element enqueueTask: ((BlTaskAction new 
			action: [ aCallback cull: aResult cull: self ]) 
				asBeaconLoggingTask maySetName: 'Success Action') ]
]

{ #category : #'api - running' }
BlEnqueuedFutureAction >> run: aWaker [

	| aPromise |
	aPromise := self runFuture.
	resultCallbacks do: [ :eachCallback | 
		self enqueuePromise: (aPromise then: eachCallback) ].
	exceptionCallbacks do: [ :eachCallback | 
		self enqueuePromise: (aPromise then: [  ] otherwise: eachCallback) ]
]

{ #category : #'api - running' }
BlEnqueuedFutureAction >> runFuture [
	| aPromise |
	aPromise := self action await: self futureConfiguration.
	self enqueuePromise: aPromise.
	^ aPromise
]
