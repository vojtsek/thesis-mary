MARY_VERSION=5.2-SNAPSHOT
MARY_BASE=/home/vojta/marytts
VOICE_TOOLS=$(MARY_BASE)/target/marytts-builder-$(MARY_VERSION)/bin/voiceimport.sh
MARY_SERVER=$(MARY_BASE)/target/marytts-$(MARY_VERSION)/bin/marytts-server
ROOT_DIR=/home/vojta/marytts-voice-building

all: AllophonesExtractor EHMMlabeler LabelPauseDeleter PhoneUnitLabelComputer TranscriptionAligner mary/features.txt PhoneUnitFeatureComputer PhonelabelFeatureAligner HMMVoiceDataPreparation HMMVoiceConfigure HMMVoiceFeatureSelection HMMVoiceMakeData HMMVoiceMakeVoice HMMVoiceCompiler

AllophonesExtractor: text/ wav/
    
    $(VOICE_TOOLS) marytts.tools.voiceimport.AllophonesExtractor

EHMMlabeler: prompt_allophones/
    $(VOICE_TOOLS) marytts.tools.voiceimport.EHMMLabeler

LabelPauseDeleter: ehmm/lab/
    $(VOICE_TOOLS) marytts.tools.voiceimport.LabelPauseDeleter

PhoneUnitLabelComputer: lab/
    $(VOICE_TOOLS) marytts.tools.voiceimport.PhoneUnitLabelComputer

TranscriptionAligner: phonelab/
    $(VOICE_TOOLS) marytts.tools.voiceimport.TranscriptionAligner

FeatureSelection: allophones/
    $(VOICE_TOOLS) marytts.tools.voiceimport.FeatureSelection

PhoneUnitFeatureComputer: mary/features.txt
    $(VOICE_TOOLS) marytts.tools.voiceimport.PhoneUnitFeatureComputer

PhonelabelFeatureAligner: phonelab/ phonefeatures/
    $(VOICE_TOOLS) marytts.tools.voiceimport.PhonelabelFeatureAligner

HMMVoiceDataPreparation: phonefeatures/ phonelab/ $(ROOT_DIR)/mary/features.txt $(MARY_BASE)/lib/external/externalBinaries.config
    $(VOICE_TOOLS) marytts.tools.voiceimport.HMMVoiceDataPreparation

HMMVoiceFeatureSelection: $(ROOT_DIR)/mary/features.txt
    $(VOICE_TOOLS) marytts.tools.voiceimport.HMMVoiceFeatureSelection

HMMVoiceMakeData: $(ROOT_DIR)/mary/hmmFeatures.txt $(ROOT_DIR)/hts/data/
    cd $(ROOT_DIR)/hts/data/

HMMVoiceMakeVoice: $(ROOT_DIR)/hts/data/
    cd $(ROOT_DIR)
    perl scripts/Training.pl scripts/Config.pm > make-voice.log

HMMVoiceCompiler: $(ROOT_DIR)/hts/data/
    $(VOICE_TOOLS) marytts.tools.voiceimport.HMMVoiceCompiler
