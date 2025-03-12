

class RecommendationQuestionAndAns {
  SkincareHistoryQuestions? skincareHistoryQuestions;
  SensitivityRelatedQuestions? sensitivityRelatedQuestions;
  SkincareGoalQuestions? skincareGoalQuestions;
  RelatedQuestionsBasedOnPrimaryConcern? relatedQuestionsBasedOnPrimaryConcern;

  RecommendationQuestionAndAns({
    this.skincareHistoryQuestions,
    this.sensitivityRelatedQuestions,
    this.skincareGoalQuestions,
    this.relatedQuestionsBasedOnPrimaryConcern,
  });

  factory RecommendationQuestionAndAns.fromJson(Map<String, dynamic> json) {
    return RecommendationQuestionAndAns(
      skincareHistoryQuestions: json['skincare_history_questions'] != null
          ? SkincareHistoryQuestions.fromJson(
          json['skincare_history_questions'])
          : null,
      sensitivityRelatedQuestions: json['sensitivity_related_questions'] !=
          null
          ? SensitivityRelatedQuestions.fromJson(
          json['sensitivity_related_questions'])
          : null,
      skincareGoalQuestions: json['skincare_goal_questions'] != null
          ? SkincareGoalQuestions.fromJson(json['skincare_goal_questions'])
          : null,
      relatedQuestionsBasedOnPrimaryConcern:
      json['related_questions_based_on_primary_concern'] != null
          ? RelatedQuestionsBasedOnPrimaryConcern.fromJson(
          json['related_questions_based_on_primary_concern'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skincare_history_questions': skincareHistoryQuestions?.toJson(),
      'sensitivity_related_questions': sensitivityRelatedQuestions?.toJson(),
      'skincare_goal_questions': skincareGoalQuestions?.toJson(),
      'related_questions_based_on_primary_concern':
      relatedQuestionsBasedOnPrimaryConcern?.toJson(),
    };
  }
}

class SkincareHistoryQuestions {
  List<Question>? questions;

  SkincareHistoryQuestions({this.questions});

  factory SkincareHistoryQuestions.fromJson(Map<String, dynamic> json) {
    return SkincareHistoryQuestions(
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions?.map((e) => e.toJson()).toList(),
    };
  }
}

class SensitivityRelatedQuestions {
  List<Question>? questions;

  SensitivityRelatedQuestions({this.questions});

  factory SensitivityRelatedQuestions.fromJson(Map<String, dynamic> json) {
    return SensitivityRelatedQuestions(
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions?.map((e) => e.toJson()).toList(),
    };
  }
}

class SkincareGoalQuestions {
  List<Question>? questions;

  SkincareGoalQuestions({this.questions});

  factory SkincareGoalQuestions.fromJson(Map<String, dynamic> json) {
    return SkincareGoalQuestions(
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions?.map((e) => e.toJson()).toList(),
    };
  }
}

class RelatedQuestionsBasedOnPrimaryConcern {
  Map<String, PrimaryConcernQuestions>? primaryConcerns;

  RelatedQuestionsBasedOnPrimaryConcern({this.primaryConcerns});

  factory RelatedQuestionsBasedOnPrimaryConcern.fromJson(
      Map<String, dynamic> json) {
    Map<String, PrimaryConcernQuestions>? concerns;
    if (json['primaryConcerns'] != null) {
      concerns = {};
      json['primaryConcerns'].forEach((key, value) {
        concerns![key] = PrimaryConcernQuestions.fromJson(
            value as Map<String, dynamic>);
      });
    }
    return RelatedQuestionsBasedOnPrimaryConcern(primaryConcerns: concerns);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    primaryConcerns?.forEach((key, value) {
      json[key] = value.toJson();
    });
    return json;
  }
}

class PrimaryConcernQuestions {
  List<Question>? questions;

  PrimaryConcernQuestions({this.questions});

  factory PrimaryConcernQuestions.fromJson(Map<String, dynamic> json) {
    return PrimaryConcernQuestions(
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions?.map((e) => e.toJson()).toList(),
    };
  }
}

class Question {
  String? question;
  List<String>? options;
  // List<String>? images;

  Question({this.question, this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : null,
      // images: json['images'] != null
      //     ? List<String>.from(json['images'])
      //     : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      // 'images': images,
    };
  }
}
