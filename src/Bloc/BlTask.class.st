"
BlTasks are the entities submitted to BlElements for execution during a pulse.

Tasks may only be submitted to a queue once.  To help identify duplicate submission, tasks now have a state, one of: 

- `#new` 					A new task 
- `#queued`				The task has been submitted to a queue
- `#pendingExecution` 	The task has been removed from the queue and is awaiting execution, see {{gtMethod:BlSpaceTaskQueue>>#runOn:}}.
- `#executing` 			The task is currently being executed.
- `#complete`				The task has completed execution.

The state must be #new when the task is submitted, otherwise an error will be raised.  This moves the discovery of duplicate task submission back from the time the task is executed in the queue to the time it is submitted.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
## Internal Representation and Key Implementation Points.

### Instance Variables
	id:			<Object>
	state:		<Symbol>


### Implementation Points

The task state was introduced after duplicate tasks were being found during the execution of {{gtClass:BlDelayedTask}}.  The resubmission of the task during execution would result in an duplicate task execution.  Our assumption is that the task has been resubmitted externally between the time it was removed from the queue pending execution and the actual execution.  Adding the state will remove / reduce this window where the task can be submitted externally, causing the exception to be raised at the time of submission, rather than during execution.

"
Class {
	#name : #BlTask,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'id',
		'state',
		'processId'
	],
	#classVars : [
		'UniqueIdGenerator'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'class initialization' }
BlTask class >> initialize [
	UniqueIdGenerator := BlUniqueIdGenerator new
]

{ #category : #converting }
BlTask >> asBeaconLoggingTask [
	^ BlBeaconLoggingTask subtask: self
]

{ #category : #accessing }
BlTask >> id [
	"Return a unique id of this task"
	<return: #Number>

	^ id
]

{ #category : #initialization }
BlTask >> initialize [
	super initialize.
	
	id := UniqueIdGenerator generateUniqueId.
	processId := Processor activeProcess name.
	state := #new.
]

{ #category : #'private - state' }
BlTask >> isComplete [

	^ state == #complete
]

{ #category : #'private - state' }
BlTask >> isExecuting [

	^ state = #executing
]

{ #category : #'api - testing' }
BlTask >> isIndefiniteTermTask [
	"Identifies whether the task may be enqueued indefinitely.
	BlScripter uses it to ignore such tasks while pulsing."

	^ false
]

{ #category : #'private - state' }
BlTask >> isNew [ 

	^ state == #new
]

{ #category : #'private - state' }
BlTask >> isPendingExecution [

	^ state == #pendingExecution
]

{ #category : #'private - state' }
BlTask >> isQueued [

	^ state == #queued
]

{ #category : #hooks }
BlTask >> onEnqueued: aBlSpace [
	"Is self when a task is enqueued in a space.
	It gives subclasses a possibility to synchronize time with the space"
]

{ #category : #hooks }
BlTask >> onEnqueuedInElement: aBlElement [
	"Is sent when a task is enqueued in a element.
	It gives subclasses a possibility to re-enqueue themselves in the same element"
]

{ #category : #accessing }
BlTask >> processId [
	^ processId
]

{ #category : #'private - testing' }
BlTask >> requeueTaskAfterExecution [
	"Answer a boolean indicating whether the receiver should be requeued after execution.
	Subclasses will override this with the appropriate response"

	^ false
]

{ #category : #'api - running' }
BlTask >> run [
	
]

{ #category : #'api - running' }
BlTask >> run: aWaker [
	"Should be implemented by subclasses"
	self run
]

{ #category : #'private - state' }
BlTask >> setComplete [

	state := #complete
]

{ #category : #'private - state' }
BlTask >> setExecuting [

	state := #executing
]

{ #category : #'private - state' }
BlTask >> setNew [

	state := #new.
]

{ #category : #'private - state' }
BlTask >> setPendingExecution [

	state := #pendingExecution.
]

{ #category : #'private - state' }
BlTask >> setQueued [

	state := #queued.
]

{ #category : #'api - running' }
BlTask >> value [
	"To support defer:"
	self run
]
