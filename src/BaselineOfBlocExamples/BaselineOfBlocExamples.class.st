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
				spec repository: 'github://feenkcom/Bloc:v0.8.215/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:a119e739bc378ca2a95883e074090d90fed4edeb/repository' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.56/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:c985fb6f3fc583598cb48183bee4e26327e505c3' ];
			baseline: 'GToolkitExamplesEngine' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.25/src' ].
		spec 
			package: #'Bloc-Text-Examples' with: [
				spec requires: #('Bloc' ). ];
			package: #'Bloc-Layout-Examples' with: [
				spec requires: #('Bloc' 'GToolkitExamplesEngine' ). ];
			package: #'Bloc-Examples' with: [
				spec requires: #('Bloc' ). ];
			package: #'Bloc-Compositor-Examples' with: [
				spec requires: #('Bloc' #'Bloc-Examples' ). ];
			package: #'Bloc-Docs' with: [
				spec requires: #('Bloc' ). ]. ].

]
