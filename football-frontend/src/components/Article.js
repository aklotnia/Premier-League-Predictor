import React from 'react'

class Article extends React.Component {

    constructor(props) {
        super(props)
        let articleAr = ['https://cdn.images.express.co.uk/img/dynamic/67/590x/Premier-League-table-1012181.jpg?r=1535964666864', "https://cdn.images.express.co.uk/img/dynamic/67/590x/Fantasy-Premier-League-tips-1207220.jpg?r=1574433895127", "https://resources.premierleague.com/premierleague/photo/2018/02/27/a4d4c12a-6f11-45d9-8f97-c1e56fc2ce34/2017-12-10T175550Z_689550499_RC1E479E7180_RTRMADP_3_SOCCER-ENGLAND-MUN-MCI.JPG", "https://usatftw.files.wordpress.com/2019/04/afp-afp_1fc8c9.jpg?w=1000&h=600&crop=1", "https://images.daznservices.com/di/library/GOAL/2/7c/chelsea-goal-abraham-2019_19se9v202079k1dhu01fwcg50g.jpg?t=-694601458&quality=100", "https://images.cdn.fourfourtwo.com/sites/fourfourtwo.com/files/styles/image_landscape/public/joe_willock_arsenal.jpg?itok=7hv8M3vB", "https://soccer.nbcsports.com/wp-content/uploads/sites/14/2019/12/GettyImages-1188892499-e1576464404606.jpg?w=610&h=343&crop=1", "https://images2.minutemediacdn.com/image/upload/c_fill,w_912,h_516,f_auto,q_auto,g_auto/shape/cover/sport/afc-bournemouth-v-crystal-palace-premier-league-5bed43935cf4823a76000001.jpg", "https://upnewsinfo.com/wp-content/uploads/2019/12/1575403322_Brighton-without-Solly-March-in-December-after-surgery-Soccer.jpg", "https://resources.premierleague.com/photos/2019/08/22/e8c0414e-0856-40b1-9c60-b9dcd473a051/MIna-Keane-Everton.jpg?width=860&height=573", "https://d3j2s6hdd6a7rg.cloudfront.net/v2/uploads/media/default/0002/01/thumb_100326_default_news_size_5.jpeg", "https://img.playbuzz.com/image/upload/q_100,f_auto,fl_lossy,w_640,c_limit/v1577101465/otgnuwsiybsjhayz0veb.jpg", "https://specials-images.forbesimg.com/imageserve/1200376291/960x0.jpg?fit=scale", "https://www.cpfc.co.uk/siteassets/images/matches/west-ham-h/00-ayew-celebrations-west-ham.jpg/Large", "https://resources.premierleague.com/photos/2019/06/14/9cf573d6-9a08-4217-a0a3-3fae27b6b0da/2019-04-22T142033Z_1458368164_RC1684CAD7A0_RTRMADP_3_SOCCER-ENGLAND-AVA-MLW.jpg?width=900&height=620", "https://thesefootballtimes.co/wp-content/uploads/2019/03/50F2946D-EA3B-4062-8B09-6E668D028804.jpeg", "https://pbs.twimg.com/media/EO7A-UuW4AEVkqh.jpg"]
        this.state = {
            image: articleAr[Math.floor(Math.random() * articleAr.length)]
        }
    }

    dateCleaner = () => {
        let date = new Date(this.props.article.webPublicationDate)
        date = date.toUTCString()
        let dateAr = date.split(",")
        dateAr.shift()
        let joined_date_str = dateAr.join("")
        return joined_date_str.substring(0, joined_date_str.length-7)
    }

    animate = () => {
        this.setState({hovered: true})
    }

    reverseAnimate = () => {
        this.setState({hovered: false})
    }

    render() {
        return(
            <a href={this.props.article.webUrl}>
            <div className="Article" onMouseEnter={this.animate} onMouseLeave={this.reverseAnimate}>
                <div className="NewsImageContainer"><img className="NewsImage" src={this.state.image} style={{transform: `${this.state.hovered? "scale(1.15, 1.15)" : "scale(1,1)"}`}} alt="Players Celebrating"/></div>
                <div className="ArticleTransientContainer"><div style={this.state.hovered? {left: "0%", right: "0%"} : null} className="ArticleTransient"></div></div>
                <div className="ArticleName">
                    <div className="NewsColor">News</div>
                    <div className="NewsArticleHeader"><a href={this.props.article.webUrl}>{this.dateCleaner()} {this.props.article.webTitle}</a></div>
                </div>
                {/* <img src={this.imageRandomizer()} alt="Soccer Ball Banner"/> */}
            </div>
            </a>

        )
    }
}

export default Article