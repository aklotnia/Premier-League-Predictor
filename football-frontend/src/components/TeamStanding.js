import React from 'react'

class TeamStanding extends React.Component {
    render () {
        return (
            <tr className="StandingHover">
                <td>{this.props.team.position}</td>
                <td><img className="StandingCrest" src={this.props.team.crest} alt={this.props.team.name} /></td>
                <td>{this.props.team.name}</td>
                <td>{this.props.team.points}</td>
                <td>{this.props.team.won_games}</td>
                <td>{this.props.team.drawn_games}</td>
                <td>{this.props.team.lost_games}</td>
                <td>{this.props.team.goals_for}</td>
                <td>{this.props.team.goals_against}</td>
                <td>{this.props.team.goal_difference}</td>
                <td>{this.props.team.played_games}</td>
            </tr>
        )
    }
}

export default TeamStanding