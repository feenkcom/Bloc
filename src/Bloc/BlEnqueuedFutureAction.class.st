Class {
	#name : #BlEnqueuedFutureAction,
	#superclass : #BlTask,
	#instVars : [
		'future',
		'action',
		'resultCallbacks',
		'exceptionCallbacks',
		'element',
		'name'
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

{ #category : #accessing }
BlEnqueuedFutureAction >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlEnqueuedFutureAction >> element: aBlElement [
	element := aBlElement
]

{ #category : #accessing }
BlEnqueuedFutureAction >> future [
	^ future
]

{ #category : #accessing }
BlEnqueuedFutureAction >> future: anObject [
	future := anObject
]

{ #category : #accessing }
BlEnqueuedFutureAction >> futureAction [
	^ self action
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
BlEnqueuedFutureAction >> run [

	future := self runFuture.
	resultCallbacks do: [ :eachCallback | future then: eachCallback ].
	exceptionCallbacks do: [ :eachCallback | 
		future then: [  ] otherwise: eachCallback ]
]

{ #category : #'api - running' }
BlEnqueuedFutureAction >> runFuture [
	^ self action await
]
