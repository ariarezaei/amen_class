function [ score ] = addValue( feats, newFeat, X )

oldScore = sfo_amen_l2_score(X, feats);
newScore = sfo_amen_l2_score(X, [feats newFeat]);

score = newScore - oldScore;

end

