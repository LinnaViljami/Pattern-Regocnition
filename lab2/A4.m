turns = 100;
peoples = 1000000;

scores = zeros(peoples,1);

%simulate rounds
for turn = 1:turns
    %simulate turn of one people
    for people = 1:peoples
        %simulate score of one throw
        scoreOfTurn = randi([0,1],1);
        %update score
        scores(people) = scores(people) + scoreOfTurn;
    end
end

%plot function amount of score against number of people
x = [0:1:turns];

%calculate count of scores
y = zeros(1, size(x,2));
for i = 1:peoples
    y(scores(i)+1) = y(scores(i)+1) + 1;
end

plot(x,y)
    