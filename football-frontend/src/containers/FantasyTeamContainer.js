import React from 'react'
import PlayerObj from '../components/PlayerObj'

class FantasyTeamContainer extends React.Component {

    state = {

    }

    componentDidMount () {
        fetch(`http://localhost:3000/players/${this.props.team}`)
        .then(resp => resp.json())
        .then(parsed => {this.setState({players: parsed})})
    }

    teamRender = () => {
        if (this.state.players) {
            return this.state.players.map((player) => {
                if (!Object.values(this.props.obj).flat().includes(player.name)) {
                    return <PlayerObj player={player} team={this.props.team} />
                } else {
                    return null
                }
            }
            )
        }
    }

    render() {
        return(
            <div className={this.props.class}>
                <div className="TeamContainerHeader" style={{backgroundColor: this.props.team === "liverpool" ? "#b81a2b" : "#071a57"}}>
                    <img className="TeamHeaderLogo" src={this.props.team === "liverpool"? "https://www.supergraphictees.com/wp-content/uploads/Liverpool-F.C.-Red.jpg" : "https://i.pinimg.com/originals/79/bd/00/79bd00c9e1ab7e30242bc47c25689e91.jpg"} alt="TeamContainerHeader"/>
                {/* <h4>
                    {this.props.team} Players
                </h4> */}
                </div>
                <div className="PlayerObjList">
                    {this.teamRender()}
                </div>
            </div>
        )
    }
}

export default FantasyTeamContainer