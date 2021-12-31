Class {
	#name : #BaselineOfBlocExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocExamples
}

{ #category : #baseline }
BaselineOfBlocExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.258/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:7d7c3cd9829e5a7e238bbfb9a3bcdf84b5e562da/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.75/src' ].
		spec
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:9b47437f0c2a3c8feb4c6d058a5d49a53e0653ac' ].
		spec
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.37/src' ].

		spec package: 'Bloc-Text-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Layout-Examples' with: [
			spec requires: #('Bloc' 'GToolkitExamplesEngine') ].
		spec package: 'Bloc-Examples' with: [
			spec requires: #('Bloc') ].
		spec package: 'Bloc-Compositor-Examples' with: [
			spec requires: #('Bloc' #'Bloc-Examples') ].
		spec package: 'Bloc-Docs' with: [
			spec requires: #('Bloc') ].
	]
]
