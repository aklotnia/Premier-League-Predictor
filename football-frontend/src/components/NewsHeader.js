import React from 'react'

class NewsHeader extends React.Component {

    render() {
        return(
            <div id="NewsHeaderGrid">
                <div id="NewsHeaderMainArticleGrid">
                    <span id="NewsHeaderMainArticleGridPhoto">
                        <img id="NewsHeaderMainArticleImage" src="MoSalah.jpg" alt="Mo Salah and Gundogan"/>
                    </span>
                    <span id="NewsHeaderMainArticleTransient">

                    </span>
                    <span id="NewsHeaderMainArticleContainer">
                        <br></br>
                        <div className="GreenHeader">News</div>
                        <h1>Mohamed Salah Masterclass Blows Open Title Race</h1>
                        <a href="https://www.givemesport.com/1546129-mo-salahs-highlights-from-the-201920-season-so-far-show-we-take-his-brilliance-for-granted">
                            <div className="ReadMore">
                                Read more
                            </div>
                        </a>
                        <div id="MoreLiverpoolNews">More Liverpool News:</div>
                        <div id="MoreLiverpoolNewsContainer">
                            <br></br>
                            <br></br>
                            <a href="https://www.liverpoolfc.com/news/first-team/386398-rickie-lambert-interview-liverpool-form">Rickie Lambert Claims: 'I've never seen the levels Liverpool are getting to before'</a>
                            <br></br>
                            <br></br>
                            <a href="https://www.liverpool.com/liverpool-fc-news/features/pep-guardiola-next-club-liverpool-17732192">Pep Guardiola's next move will change everything for Liverpool in the Premier League</a>
                            <br></br>
                            <br></br>
                            <a href="https://www.thisisanfield.com/2020/02/liverpools-timeline-to-complete-anfield-road-end-expansion-revealed/">Liverpool’s timeline to complete Anfield Road End expansion revealed</a>
                        </div>
                    </span>
                    <span id="NewsHeaderMainArticleContainerOpacity">
                    </span>
                </div>
                <div id="NewsHeaderGridBreak">
                </div>
                <div id="NewsHeaderSubArticleGrid">
                    <div id="NewsHeaderSubArticle1Grid">
                        <img className="SubArticleImage" src="https://i2-prod.manchestereveningnews.co.uk/incoming/article16877674.ece/ALTERNATES/s615/0_Manchester-City-v-Brighton-Hove-Albion-Premier-League.jpg" alt="Manchester City Players"/>
                        <div className="SubArticleTransient">

                        </div>
                        <div className="SubArticleText" style={{padding: "20px", marginTop: "5px"}}>
                            <div className="GreenHeader">Manchester City</div>
                                <h3 className="SubArticleHeadline">Agüero Gives City Edge Over United; Title Hopes Still Alive</h3>
                                <a href="https://www.goal.com/en-in/news/aguero-has-transformed-into-a-complete-striker-under/lbnb8ysp6cm71xssm8r3wxkrb"><div className="ReadMore">Read More</div></a>
                        </div>
                        <div className="NewsHeaderSubArticleBackground">

                        </div>
                    </div>
                    <div id="NewsHeaderSubBreak">
                    </div>
                    <div id="NewsHeaderSubArticle2Grid">
                        <img className="SubArticleImage" src="https://www.clubcall.com/content/uploads/2020/01/Raul-Jimenez.jpg" alt="Wolves Players"/>
                        <div className="SubArticleTransient">

                        </div>
                        <div className="SubArticleText" style={{padding: "20px", marginTop: "5px"}}>
                            <div className="GreenHeader">Wolverhampton Wanderers</div>
                                <h3 className="SubArticleHeadline">Jiménez and Traore Combine for Huge Impact</h3>
                                <a href="https://www.goal.com/en-us/news/wolves-adama-traore-and-jimenez-set-record-in-liverpool/5fuww3t3lztr1iriliilyn1ad"><div className="ReadMore">Read More</div></a>
                        </div>
                        <div className="NewsHeaderSubArticleBackground">

                        </div>
                    </div>
                </div>
            </div>
        )
    }

}

export default NewsHeader